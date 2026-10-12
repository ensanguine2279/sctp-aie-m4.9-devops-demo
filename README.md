Completed devops-demo app for [Lesson 4.9: Tool Exploration - CI/CD Tools](https://github.com/su-ntu-sctp/ai-4.9-Tool-Exploration/blob/main/lesson.md)

### Attempted workflows in GitHub Action

![Attempted workflows](assets/images/github-actions-workflows.jpg)

### Initial Workflow

![Workflow after initial push](assets/images/github-actions-workflow-initial.jpg)

### Image published to Docker Hub

![Image pushed to DockerHub](assets/images/dockerhub-images.jpg)

### Failed Workflow (after changing `DemoController.java`)

![Failed workflow](assets/images/github-actions-workflow-failed.jpg)

A mismatch of response content (due to change in `DemoController.java`) causes the test to fail.

```bash
-------------------------------------------------------------------------------
Test set: com.example.devopsdemo.controller.DemoControllerTest
-------------------------------------------------------------------------------
Tests run: 1, Failures: 1, Errors: 0, Skipped: 0, Time elapsed: 0.311 s <<< FAILURE! -- in com.example.devopsdemo.controller.DemoControllerTest
com.example.devopsdemo.controller.DemoControllerTest.testHelloEndpoint -- Time elapsed: 0.054 s <<< FAILURE!
java.lang.AssertionError: Response content expected:<DevOps demo application is running!> but was:<DevOps demo - GitHub Actions is working!>
	at org.springframework.test.util.AssertionErrors.fail(AssertionErrors.java:62)
	at org.springframework.test.util.AssertionErrors.assertEquals(AssertionErrors.java:129)
	at org.springframework.test.web.servlet.result.ContentResultMatchers.lambda$string$1(ContentResultMatchers.java:148)
	at org.springframework.test.web.servlet.MockMvc$1.andExpect(MockMvc.java:212)
	at com.example.devopsdemo.controller.DemoControllerTest.testHelloEndpoint(DemoControllerTest.java:30)
```


### Successful Workflow (after changing test case in `DemoControllerTest.java`)

![Successful Worflow](assets/images/github-actions-workflow-success.jpg)

## Using Docker Github Actions

Instead of manually running `docker build` and `docker push` using shell commands, it is safer and cleaner to use Docker's official GitHub Actions (`docker/login-action` and `docker/build-push-action`).

```bash
  # ==========================================
  # PUBLISH JOB - Build and push Docker image
  # ==========================================
  publish:
    runs-on: ubuntu-latest
    needs: test

    steps:
      - name: Checkout code
        uses: actions/checkout@v7

      - name: Get JAR from the build job
        uses: actions/download-artifact@v8
        with:
          name: app-jar
          path: target

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v6
        with:
          context: .
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/devops-demo:latest
```

## GitHub Actions Cache

Add build caching to speed up Docker builds. You can add Docker layer caching using the GitHub Actions Cache API (gha), add the `docker/setup-buildx-action` step and append `cache-from` and `cache-to` properties to the `docker/build-push-action` step.

```bash
  # ==========================================
  # PUBLISH JOB - Build and push Docker image
  # ==========================================
  publish:
    runs-on: ubuntu-latest
    needs: test

    steps:
      - name: Checkout code
        uses: actions/checkout@v7

      - name: Get JAR from the build job
        uses: actions/download-artifact@v8
        with:
          name: app-jar
          path: target

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v6
        with:
          context: .
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/devops-demo:latest
          cache-from: type=gha
          cache-to: type=gha,mode=max
```