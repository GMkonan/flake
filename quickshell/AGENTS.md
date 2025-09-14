# Quickshell Configuration Agent Guide

## Project Overview
This is a Quickshell configuration for a desktop bar/panel system using QML. Quickshell is a Qt-based shell for creating desktop widgets and panels.

## Running & Testing
- **Run**: `qs` (Quickshell auto-reloads on file changes)
- **No build/test commands**: This is a configuration project, not a compiled application

## Code Style Guidelines

### File Structure
- Main entry: `shell.qml`
- Bar components: `bar/` directory with `Bar.qml` as main component
- Blocks: `bar/blocks/` for individual UI components (Battery.qml, Workspaces.qml, etc.)
- Utils: `bar/utils/` for utility singletons (HyprlandUtils.qml, KeyboardLayoutService.qml)
- Theme: `Theme.qml` singleton for color schemes

### QML Conventions
- Use `pragma Singleton` for utility classes
- Import order: Quickshell modules first, QtQuick second, local imports last with aliases
- Property declarations before functions
- Use camelCase for properties and functions
- Use PascalCase for component names and files

### Naming & Structure
- Component files: PascalCase (e.g., `Battery.qml`, `HyprlandUtils.qml`)
- Properties: camelCase (e.g., `maxWorkspace`, `hasBattery`)
- Functions: camelCase with descriptive names (e.g., `switchWorkspace`, `findMaxId`)
- Use `id:` for main component identification

### Error Handling
- Use `onExited` for Process components to handle command failures
- Provide fallback values (e.g., `|| 1` for workspace counts)
- Use `console.log()` for debugging workspace events and state changes