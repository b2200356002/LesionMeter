from aws_cdk import (
    aws_lambda as _lambda,
    aws_apigateway as apigw,
    aws_s3 as s3,
    Stack,
)
from constructs import Construct


class SkinLesionStack(Stack):
    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # Create S3 bucket
        bucket = s3.Bucket(self, "SkinLesionBucket")

        # Create Lambda function
        skin_lesion_lambda = _lambda.Function(
            self, "SkinLesionLambda",
            function_name="SkinLesionLambda",
            runtime=_lambda.Runtime.PYTHON_3_12,
            handler="skin_lesion.lambda_handler",
            code=_lambda.Code.from_asset("lambda"),
            environment={
                'BUCKET_NAME': bucket.bucket_name
            }

        )

        # Grant permission to Lambda to write to the bucket
        bucket.grant_write(skin_lesion_lambda)

        # Create API Gateway
        api = apigw.RestApi(
            self, "SkinLesionAPI",
            rest_api_name="SkinLesion API",
            description="Endpoint for skin lesion measurement"
        )

        # Define Lambda integration
        skin_lesion_integration = apigw.LambdaIntegration(skin_lesion_lambda)

        # Define API resource
        skin_lesion_resource = api.root.add_resource("skin-lesion")

        # Add method to resource
        skin_lesion_resource.add_method(
            "POST",
            skin_lesion_integration,
            api_key_required=False
        )
