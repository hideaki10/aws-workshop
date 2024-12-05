const AWS = require('aws-sdk');
const dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    try {
        const body = JSON.parse(event.body);
        const tableName = process.env.DYNAMODB_TABLE;
        
        const params = {
            TableName: tableName,
            Item: {
                id: body.id || Date.now().toString(),
                ...body
            }
        };
        
        await dynamodb.put(params).promise();
        
        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'Item created successfully' })
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: error.message })
        };
    }
}; 