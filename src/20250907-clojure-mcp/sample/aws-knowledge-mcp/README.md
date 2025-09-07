# aws-knowledge-mcp

[awslabs/mcp/aws-knowledge-mcp](https://github.com/awslabs/mcp/tree/main/src/aws-knowledge-mcp-server)

## Initialize

```
$ pnpm -C cdk i
```

## Deploy

```
$ pnpm -C cdk exec cdk deploy --require-approval=never --profile conao3.sandbox 
```

## Tips

### Install aws-knowledge-mcp

Configure aws-knowledge-mcp for claude-code.

```
claude mcp add --transport http aws-knowledge-mcp-server --scope user https://knowledge-mcp.global.api.aws
```

As a user, we only need to configure it to use HTTP-provided MCP server, making it extremely convenient.

### Find unconfigured flags

```
$ pnpm -C cdk exec cdk flags --unstable=flags
```
