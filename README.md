# Demo Java Web Application

## Deployment Troubleshooting

**Error:**  
`Error during artifact deployment. ... /target/pahana-edu-pos not found for the web module.`

**What's happening:**  
Your deployment configuration specifies an artifact name (`pahana-edu-pos`) that does not match your current project artifact/build. This typically happens when the project/artifact is renamed and IntelliJ or your server is still referencing the old name.

**How to fix:**

### 1. Remove Old/Invalid Artifact Entries
- In IntelliJ, go to **File > Project Structure > Artifacts**.
- Delete any artifacts named `pahana-edu-pos` (or any that do not match your project's actual output/artifact).
- Create a new artifact if necessary (usually of type `war exploded` or `war`), and ensure its output directory matches your project's build output (often `target/demo:war exploded` or similar).

### 2. Update Server Deployment Configuration
- In the **Run/Debug Configurations** for Tomcat, go to the **Deployment** tab.
- Remove any entries that point to `pahana-edu-pos`.
- Add your (new or current) artifact, e.g., `demo:war exploded`.

### 3. Rebuild and Verify
- Clean and build your project for fresh output:
  ```bash
  mvn clean package
  ```
- Ensure that `target/demo.war` (or your configured artifact name) exists.

### 4. Redeploy
- Restart Tomcat and redeploy via IntelliJ.
- The error should be resolved if the correct artifact is referenced.

**Tip:**  
Whenever you rename your project or change artifact settings, always verify IntelliJ artifact and deployment configurations to prevent broken references.

## Build

After code/content changes, always run:
