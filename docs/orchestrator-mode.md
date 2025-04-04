# Orchestrator Mode

The Orchestrator mode is a specialized RooPARS mode designed for managing complex workflows and project coordination. This mode excels at breaking down complex projects into well-defined subtasks and delegating them to specialized agents.

## Key Capabilities

The Orchestrator mode offers the following key capabilities:

1. **Strategic Task Decomposition**: Breaking complex projects into manageable components with clear dependencies
2. **Specialized Agent Coordination**: Directing tasks to the appropriate specialized modes (Architect, Code, Test, Debug, Ask)
3. **Memory Bank Management**: Comprehensive tracking of project progress and context
4. **Quality Assurance**: Ensuring deliverables meet acceptance criteria

## Workflow Process

The Orchestrator follows this general workflow:

1. **Initial Engagement**
   - Assess request validity
   - Gather requirements through targeted questions
   - Determine planning vs. execution mode
   - Reference Memory Bank to align with established patterns

2. **Task Decomposition**
   - Break projects into components with clear dependencies and acceptance criteria
   - Document using structured task definitions
   - Ensure alignment with systemPatterns.md
   - In planning mode: present breakdown for user approval

3. **Task Delegation**
   - Match tasks to appropriate team members based on specializations
   - Use delegation tools with complete parameters
   - Include relevant Memory Bank context with each delegation

4. **Progress Monitoring**
   - Track workflow status (Pending, In Progress, Completed, Blocked)
   - Update Memory Bank after each task completion
   - Check in with user after each task with results summary
   - In planning mode: wait for user confirmation before proceeding

5. **Quality Assurance**
   - Validate deliverables against acceptance criteria
   - For issues: create remediation briefs
   - Document lessons learned

6. **Project Completion**
   - Compile components into cohesive deliverables with documentation
   - Perform comprehensive update of Memory Bank files

## When to Use Orchestrator Mode

Use Orchestrator mode when:

- Working on complex, multi-part projects
- Managing a project with multiple components and dependencies
- Needing structured planning and execution
- Coordinating work across different project aspects

## Using Orchestrator Mode

To use Orchestrator mode:

1. Select "Orchestrator" from the mode dropdown in Roo
2. Start with a high-level project description or goal
3. Let the Orchestrator guide you through planning and executing your project

## Core Principles

The Orchestrator mode operates on these core principles:

- Serves EXCLUSIVELY as an orchestration layer
- All significant changes must be documented in Memory Bank
- In planning mode: explicit user approval required before each new task
- In execution mode: informs user of progress and continues unless directed otherwise