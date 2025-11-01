# Security Policy

## Supported Versions

We release patches for security vulnerabilities. Currently supported versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |
| < 0.1.0 | :x:                |

## Reporting a Vulnerability

We take the security of File Type Plus seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### How to Report

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via email to:
- **Email**: hossameldinmi@gmail.com
- **Subject**: [SECURITY] File Type Plus - Brief Description

### What to Include

Please include the following information in your report:

1. **Description** - A clear description of the vulnerability
2. **Impact** - What can an attacker do with this vulnerability?
3. **Reproduction Steps** - Step-by-step instructions to reproduce the issue
4. **Affected Versions** - Which versions are affected?
5. **Suggested Fix** - If you have ideas on how to fix it (optional)
6. **Your Contact Info** - How can we reach you for follow-up?

### What to Expect

- **Acknowledgment**: We will acknowledge receipt of your report within 48 hours
- **Investigation**: We will investigate and validate the vulnerability
- **Updates**: We will keep you informed of our progress
- **Resolution**: Once fixed, we will:
  - Release a security patch
  - Credit you in the release notes (unless you prefer to remain anonymous)
  - Publish a security advisory

### Security Best Practices

When using File Type Plus:

1. **Validate Input**: Always validate file paths and byte data from untrusted sources
2. **Handle Errors**: Properly handle cases where file type detection returns `null` or `FileType.other`
3. **File Upload Security**: 
   - Don't rely solely on file extension for security decisions
   - Use `FileType.fromBytes()` to verify actual file content
   - Implement additional server-side validation
4. **Path Traversal**: Sanitize file paths before using them in file system operations
5. **Resource Limits**: When processing byte data, limit the amount of data read from files

### Disclosure Policy

- We follow a coordinated disclosure policy
- Security issues will be disclosed publicly after a fix is available
- We aim to release patches within 30 days of receiving a valid report

## Security Updates

Security updates will be announced:
- In the [CHANGELOG.md](CHANGELOG.md)
- In GitHub release notes
- Via GitHub Security Advisories

## Questions?

If you have questions about this security policy, please contact us at hossameldinmi@gmail.com.

---

Thank you for helping keep File Type Plus and its users safe!
