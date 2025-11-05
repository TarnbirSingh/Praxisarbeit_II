#import "@preview/supercharged-dhbw:3.4.1": *

= Anhang

== System-Prompt <anh:system_prompt>
#figure(
  block(
    fill: luma(240),
    inset: 8pt,
    radius: 4pt,
    ```text
Generate a production-ready GitHub Actions workflow YAML for SAP CAP deployment to {target_env}.

REQUIREMENTS:
- Return ONLY the YAML content, no explanations
- No markdown code blocks 
- Start directly with 'name:'

PRODUCTION-GRADE FEATURES:
1. Separate CI/CD jobs: 
   - Job 1: build-test (runs on all PRs and pushes)
   - Job 2: deploy (only on main ‚branch, depends on build-test)

2. Comprehensive testing:
   - npm ci (clean install)
   - npx cds compile srv --to csn (validate CDS models)
   - npm test (if test script exists)
   - npm run build (CDS build)

3. Robust MTAR handling:
   - Generate MTAR with consistent naming in build-test job
   - Upload MTAR as artifact
   - In deploy job:
       - Download MTAR artifact - not @sap/mbt -> npx -y -p mbt mbt build...
       - Dynamically find MTAR file (do not rely on fixed path or commit SHA)
       - Deploy job must be restartable independently of build-test reruns

4. Smart triggering:
   - on: push: branches: [main] AND pull_request: branches: [main]
   - Deploy job runs only on push to main

5. Error handling:
   - Use 'set -e' in multi-line scripts
   - Chain commands with && for early failure detection
   - Proper working directory management

6. Professional structure:
   - Clear job names and step descriptions
   - Proper Node.js version matrix or fixed version
   - **Install Cloud Foundry CLI directly in deploy job**
       - Do not rely on deprecated cloudfoundry/cf-cli-action
       - Download official v8 Linux binary
       - Extract archive and move the `cf` binary from its subdirectory into /usr/local/bin/ so it is in PATH
       - Verify installation with `cf version`
       - Install Multiapps plugin in deploy job after CLI setup
   - Secret management for CF credentials (CF_API, CF_ORG, CF_SPACE, CF_USERNAME, CF_PASSWORD)

7. PR-Integration:
    - build-test job runs on PRs to validate changes before merging

8. Deploy job (always do as referenced here!): 
    - Very Important!: use the following guide as reference for ubuntu/Linux setup from the official docs:
    Linux installation
    To install the cf CLI on Debian and Ubuntu-based Linux distributions:

    Add the Cloud Foundry Foundation public key and package repository to your system by running:

    wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo gpg --dearmor -o /usr/share/keyrings/cli.cloudfoundry.org.gpg
    echo "deb [signed-by=/usr/share/keyrings/cli.cloudfoundry.org.gpg] https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
    Update your local package index by running:
    sudo apt-get update
    To install cf CLI v7, run:
    sudo apt-get install cf7-cli
    To install cf CLI v8, run:
    sudo apt-get install cf8-cli

IMPORTANT:
- `npm ci` will fail if package.json and lockfile are out of sync. Update lockfile before continuing.

OUTPUT:
- YAML only, starting with 'name:'
- Keep the **build-test commands exactly as before**
- Adjust **deploy job steps** to:
    - Dynamically detect MTAR from artifact
    - Install CF CLI correctly from official binary with proper path handling
    - Install Multiapps plugin
    - Use CF secrets correctly
    - Ensure deploy job is restartable
    
Use the following files for guidance and orientation:{files_section}
    ```
  ),
  caption: [Vollständiger System-Prompt für den `AI Core Integration Layer`.],
  supplement: "Listing"
)
