# RooPARS

RooPARS is a customized version of RooFlow specifically designed for PARS-related projects. It provides persistent project context and streamlined AI-assisted development for VS Code's Roo extension, with additional modes like the Orchestrator mode for complex project management.

## 🎯 Overview

RooPARS enhances AI-assisted development in VS Code by providing **persistent project context** and **optimized mode interactions**, resulting in **reduced token consumption** and a more efficient workflow. It builds upon RooFlow and includes PARS-specific enhancements.

### Key Features

* All standard RooFlow features (Architect, Code, Test, Debug, and Ask modes)
* **Orchestrator Mode**: Enhanced workflow orchestration for complex projects
* **Simplified Setup**: Easy installation via script
* **PARS-Specific Optimizations**: Tailored for DOE PARS-related development

## 🚀 Quick Start

### 1. Quick Installation

Run our setup script to automatically install RooPARS in your project:

```bash
# For Linux/macOS
curl -L https://raw.githubusercontent.com/PARS-DOE/roopars/main/install.sh | bash

# For Windows (PowerShell)
iwr -useb https://raw.githubusercontent.com/PARS-DOE/roopars/main/install.ps1 | iex
```

### 2. Manual Installation

1. Clone this repository or download the files
2. Copy the configuration files to your project:
   ```bash
   # From the roopars directory
   cp -r config/.roo config/.roomodes config/.rooignore install.sh path/to/your/project/
   ```
3. Run the insert-variables script in your project directory:
   ```bash
   cd path/to/your/project
   chmod +x insert-variables.sh
   ./insert-variables.sh
   ```

### 3. Using RooPARS

1. Open your project in VS Code with the Roo extension installed
2. Select an appropriate mode for your task (Architect, Code, Test, Debug, Ask, or Orchestrator)
3. Start a chat with Roo and begin working
4. For complex project orchestration, use the Orchestrator mode

## 📚 Memory Bank

The Memory Bank structure follows the standard RooFlow approach with these Markdown files:

| File | Purpose |
|------|---------|
| `activeContext.md` | Current session context, recent changes, and goals |
| `decisionLog.md` | Architecture and implementation decisions |
| `productContext.md` | Project overview, goals, and architecture |
| `progress.md` | Project progress tracking |
| `systemPatterns.md` | Recurring patterns and standards |

## 📝 Commands

* **Update Memory Bank (UMB)**: Updates the memory bank with current session information
* **Switch Mode**: Changes between different operational modes

## License

[Apache 2.0](LICENSE)