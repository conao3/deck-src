#!/usr/bin/env node
import "source-map-support/register";
import * as cdk from "aws-cdk-lib";
import { CdkLambdaHelloStack } from "../lib/cdk-lambda-hello-stack";

const app = new cdk.App();
new CdkLambdaHelloStack(app, "CdkLambdaHelloStack");
