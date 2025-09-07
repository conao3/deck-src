# aws-knowledge-mcp

## Initialize

```
$ pnpm -C cdk i
```

## Deploy

```
$ pnpm -C cdk exec cdk deploy --require-approval=never --profile conao3.sandbox 
```

## Tips

### Find unconfigured flags

```
$ pnpm -C cdk exec cdk flags --unstable=flags
```
