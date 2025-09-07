#!/usr/bin/env node
import "source-map-support/register";
import * as cdk from "aws-cdk-lib";
import { CdkLambdaHelloStack } from "../lib/cdk-lambda-hello-stack";

const app = new cdk.App();

const environment = "dev";
const project = "mcptest";

new CdkLambdaHelloStack(app, `${environment}-${project}-stack`, {
  environment,
  project,
});
