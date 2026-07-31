# Godot runner boundary

Company OS controls Godot through authenticated, project-scoped runner endpoints.

The control plane and Android application do not embed user game projects in this repository. A deployed runner mounts the selected project workspace, executes the typed Godot commands, and returns scene, Inspector, log, preview, test, and build results through the protected control-plane routes.

Godot project snapshots remain outside the mobile application package and must be resolved from the authorized project workspace.