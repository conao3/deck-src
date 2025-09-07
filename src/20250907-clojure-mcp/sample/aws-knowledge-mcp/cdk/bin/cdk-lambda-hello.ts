#!/usr/bin/env node
import "source-map-support/register";
import * as cdk from "aws-cdk-lib";
import { Stack } from "../lib/stack";

const app = new cdk.App();

const environment = "dev";
const project = "mcptest";

new Stack(app, `${environment}-${project}-stack`, {
  environment,
  project,
});
