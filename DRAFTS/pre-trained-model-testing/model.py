import numpy as np
import cv2
import matplotlib.pyplot as plt
from keras.models import Model
from keras.layers import Input, concatenate, Conv2D, MaxPooling2D, UpSampling2D, Dropout, Reshape, BatchNormalization, Activation, ConvLSTM2D, Conv2DTranspose
from keras.optimizers import Adam
import os

# Create the output directory if it doesn't exist
output_dir = 'output_images'
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Define the BCDU-Net-D3 model architecture
def BCDU_net_D3(input_size=(256, 256, 3)):
    inputs = Input(input_size)
    conv1 = Conv2D(64, 3, activation='relu', padding='same', kernel_initializer='he_normal')(inputs)
    conv1 = Conv2D(64, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv1)
  
    pool1 = MaxPooling2D(pool_size=(2, 2))(conv1)
    conv2 = Conv2D(128, 3, activation='relu', padding='same', kernel_initializer='he_normal')(pool1)
    conv2 = Conv2D(128, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv2)
    pool2 = MaxPooling2D(pool_size=(2, 2))(conv2)
    conv3 = Conv2D(256, 3, activation='relu', padding='same', kernel_initializer='he_normal')(pool2)
    conv3 = Conv2D(256, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv3)
    drop3 = Dropout(0.5)(conv3)
    pool3 = MaxPooling2D(pool_size=(2, 2))(conv3)
    # D1
    conv4 = Conv2D(512, 3, activation='relu', padding='same', kernel_initializer='he_normal')(pool3)
    conv4_1 = Conv2D(512, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv4)
    drop4_1 = Dropout(0.5)(conv4_1)
    # D2
    conv4_2 = Conv2D(512, 3, activation='relu', padding='same', kernel_initializer='he_normal')(drop4_1)
    conv4_2 = Conv2D(512, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv4_2)
    conv4_2 = Dropout(0.5)(conv4_2)
    # D3
    merge_dense = concatenate([conv4_2, drop4_1], axis=3)
    conv4_3 = Conv2D(512, 3, activation='relu', padding='same', kernel_initializer='he_normal')(merge_dense)
    conv4_3 = Conv2D(512, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv4_3)
    drop4_3 = Dropout(0.5)(conv4_3)

    up6 = Conv2DTranspose(256, kernel_size=2, strides=2, padding='same', kernel_initializer='he_normal')(drop4_3)
    up6 = BatchNormalization(axis=3)(up6)
    up6 = Activation('relu')(up6)

    x1 = Reshape(target_shape=(1, int(256/4), int(256/4), 256))(drop3)
    x2 = Reshape(target_shape=(1, int(256/4), int(256/4), 256))(up6)
    merge6 = concatenate([x1, x2], axis=1)
    merge6 = ConvLSTM2D(filters=128, kernel_size=(3, 3), padding='same', return_sequences=False, go_backwards=True, kernel_initializer='he_normal')(merge6)
            
    conv6 = Conv2D(256, 3, activation='relu', padding='same', kernel_initializer='he_normal')(merge6)
    conv6 = Conv2D(256, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv6)

    up7 = Conv2DTranspose(128, kernel_size=2, strides=2, padding='same', kernel_initializer='he_normal')(conv6)
    up7 = BatchNormalization(axis=3)(up7)
    up7 = Activation('relu')(up7)

    x1 = Reshape(target_shape=(1, int(256/2), int(256/2), 128))(conv2)
    x2 = Reshape(target_shape=(1, int(256/2), int(256/2), 128))(up7)
    merge7 = concatenate([x1, x2], axis=1)
    merge7 = ConvLSTM2D(filters=64, kernel_size=(3, 3), padding='same', return_sequences=False, go_backwards=True, kernel_initializer='he_normal')(merge7)
        
    conv7 = Conv2D(128, 3, activation='relu', padding='same', kernel_initializer='he_normal')(merge7)
    conv7 = Conv2D(128, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv7)

    up8 = Conv2DTranspose(64, kernel_size=2, strides=2, padding='same', kernel_initializer='he_normal')(conv7)
    up8 = BatchNormalization(axis=3)(up8)
    up8 = Activation('relu')(up8)

    x1 = Reshape(target_shape=(1, 256, 256, 64))(conv1)
    x2 = Reshape(target_shape=(1, 256, 256, 64))(up8)
    merge8 = concatenate([x1, x2], axis=1)
    merge8 = ConvLSTM2D(filters=32, kernel_size=(3, 3), padding='same', return_sequences=False, go_backwards=True, kernel_initializer='he_normal')(merge8)

    conv8 = Conv2D(64, 3, activation='relu', padding='same', kernel_initializer='he_normal')(merge8)
    conv8 = Conv2D(64, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv8)
    conv8 = Conv2D(2, 3, activation='relu', padding='same', kernel_initializer='he_normal')(conv8)
    conv9 = Conv2D(1, 1, activation='sigmoid')(conv8)

    model = Model(inputs, conv9)
    model.compile(optimizer=Adam(learning_rate=1e-4), loss='binary_crossentropy', metrics=['accuracy'])
    return model

# Load the model architecture
model = BCDU_net_D3(input_size=(256, 256, 3))

# Load the pretrained weights
model.load_weights('weight_isic18.hdf5')

# Function to preprocess image
def preprocess_image(image_path, target_size=(256, 256)):
    image = cv2.imread(image_path)
    image = cv2.resize(image, target_size)
    image = image.astype('float32') / 255.0
    image = np.expand_dims(image, axis=0)
    return image

# Function to post-process and visualize results
def post_process_and_visualize(image_path, segmentation_mask, output_dir):
    # Load the original image
    original_image = cv2.imread(image_path)
    original_image = cv2.cvtColor(original_image, cv2.COLOR_BGR2RGB)
    
    # Resize the segmentation mask to the original image size
    segmentation_mask_resized = cv2.resize(segmentation_mask, (original_image.shape[1], original_image.shape[0]))

    # Calculate the area of the lesions
    lesion_area = np.sum(segmentation_mask_resized == 1)
    total_area = segmentation_mask_resized.size
    lesion_percentage = (lesion_area / total_area) * 100

    print(f"Lesion Area: {lesion_area} pixels")
    print(f"Total Image Area: {total_area} pixels")
    print(f"Lesion Percentage: {lesion_percentage:.2f}%")

    # Draw circles around the detected lesions
    output_image = original_image.copy()
    contours, _ = cv2.findContours(segmentation_mask_resized.astype(np.uint8), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    for contour in contours:
        if cv2.contourArea(contour) > 50:  # Filter small contours
            (x, y), radius = cv2.minEnclosingCircle(contour)
            center = (int(x), int(y))
            radius = int(radius)
            cv2.circle(output_image, center, radius, (0, 255, 0), 2)

    # Save the images
    original_image_path = os.path.join(output_dir, 'original_image.jpg')
    segmentation_mask_path = os.path.join(output_dir, 'segmentation_mask.jpg')
    output_image_path = os.path.join(output_dir, 'output_image.jpg')

    cv2.imwrite(original_image_path, cv2.cvtColor(original_image, cv2.COLOR_RGB2BGR))
    cv2.imwrite(segmentation_mask_path, (segmentation_mask_resized * 255).astype(np.uint8))
    cv2.imwrite(output_image_path, cv2.cvtColor(output_image, cv2.COLOR_RGB2BGR))

    # Display the output image with circles around lesions
    plt.figure(figsize=(10, 10))
    plt.imshow(output_image)
    plt.title('Skin Lesions Highlighted')
    plt.show()

# Load and preprocess the image
image_path = "image.jpg"  # Change to your image path
input_image = preprocess_image(image_path)

# Perform segmentation
prediction = model.predict(input_image)
segmentation_mask = (prediction[0, :, :, 0] > 0.5).astype(np.uint8)

# Post-process and visualize the results
post_process_and_visualize(image_path, segmentation_mask, output_dir)
