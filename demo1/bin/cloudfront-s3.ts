#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { CloudfrontS3Stack } from '../lib/cloudfront-s3-stack';

const app = new cdk.App();
new CloudfrontS3Stack(app, 'CloudfrontS3Stack', {
    env: {
        region: 'ap-northeast-1',
    },
});
app.synth();