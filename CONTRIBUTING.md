# Contributing to Trello MongoDB Archiver

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:

- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Your environment (AWS region, Python version, etc.)
- Relevant logs or error messages

### Suggesting Enhancements

We welcome feature requests! Please open an issue with:

- Clear description of the feature
- Use case and benefits
- Any implementation ideas you have

### Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/trello-mongodb-archiver.git
   cd trello-mongodb-archiver
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Write clear, commented code
   - Follow the existing code style
   - Add tests if applicable

4. **Test your changes**
   - Test locally with your own AWS/Trello/MongoDB setup
   - Ensure no existing functionality is broken

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add feature: brief description"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request**
   - Provide a clear description of changes
   - Reference any related issues
   - Include screenshots if applicable

## Development Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/trello-mongodb-archiver.git
   cd trello-mongodb-archiver
   ```

2. **Set up environment**
   ```bash
   # Copy environment template
   cp .env.example .env
   
   # Edit with your credentials
   nano .env
   ```

3. **Install dependencies**
   ```bash
   cd src
   pip install -r requirements.txt
   ```

4. **Test locally**
   ```python
   # Set environment variables
   export MONGO_URI="your_uri"
   export MONGO_DB="test_db"
   export MONGO_COLLECTION="test_collection"
   
   # Run function locally
   python lambda_function.py
   ```

## Code Style

- Follow PEP 8 for Python code
- Use meaningful variable and function names
- Add docstrings to functions
- Keep functions focused and single-purpose
- Comment complex logic

Example:
```python
def process_card_event(event_data):
    """
    Process a Trello card event and extract relevant information.
    
    Args:
        event_data (dict): Trello webhook event data
        
    Returns:
        dict: Normalized card information
    """
    # Implementation
    pass
```

## Testing

Before submitting:

1. Test with various Trello card scenarios
2. Verify MongoDB insertion
3. Check CloudWatch logs for errors
4. Ensure webhook registration works

## Documentation

When adding features:

1. Update README.md if user-facing
2. Update API documentation if changing structure
3. Add setup instructions if needed
4. Include code examples

## Commit Messages

Use clear, descriptive commit messages:

- ✅ `Add support for card descriptions in MongoDB`
- ✅ `Fix MongoDB connection timeout issue`
- ✅ `Update documentation for webhook setup`
- ❌ `update stuff`
- ❌ `fixed it`

## Questions?

Feel free to open an issue for any questions about contributing!

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
