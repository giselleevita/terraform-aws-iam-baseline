# Contributing to terraform-aws-iam-baseline

Thank you for your interest in this project. Contributions are welcome.

## How to Contribute

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes and test them
4. Run `terraform fmt -recursive` to format code
5. Run `terraform validate` to check syntax
6. Commit with clear messages: `git commit -m "feat: description"`
7. Push and open a pull request

## Code Standards

- Use `terraform fmt` for consistent formatting
- Add validation rules to new variables
- Update README.md with any new inputs/outputs
- Keep security-first mindset: default to least privilege
- Test changes against the example if possible

## Testing

Before submitting a PR:

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
tflint --recursive
tfsec
```

## Questions?

Open an issue or reach out to discuss ideas before large changes.
