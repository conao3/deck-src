import * as cdk from "aws-cdk-lib";
import * as lambda from "aws-cdk-lib/aws-lambda";
import { Construct } from "constructs";

export interface CdkLambdaHelloStackProps extends cdk.StackProps {
  environment: string;
  project: string;
}

export class CdkLambdaHelloStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props: CdkLambdaHelloStackProps) {
    super(scope, id, props);

    const prefix = `${props.environment}-${props.project}`;

    const helloLambda = new lambda.Function(this, "HelloLambda", {
      functionName: `${prefix}-hello-lambda`,
      runtime: lambda.Runtime.PYTHON_3_12,
      handler: "handler.lambda_handler",
      code: lambda.Code.fromAsset("../lambda"),
    });
  }
}
