#!/usr/bin/env python3

import aws_cdk as cdk

from cdk_workshop.skin_lesion_stack import SkinLesionStack


app = cdk.App()
SkinLesionStack(app, "SkinLesionStack")

app.synth()
