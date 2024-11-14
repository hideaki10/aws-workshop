import * as cdk from 'aws-cdk-lib';
import { Template } from 'aws-cdk-lib/assertions';
// import * as Demo1 from '../lib/demo1-stack';
import * as CloudfrontS3 from '../lib/cloudfront-s3-stack';

describe('Demo1', () => {

    // snapshot test
    test('snapshot test', () => {
        const app = new cdk.App();
        const stack = new CloudfrontS3.CloudfrontS3Stack(app, 'MyTestStack');
        const template = Template.fromStack(stack);
        expect(template.toJSON()).toMatchSnapshot();
    });
});
