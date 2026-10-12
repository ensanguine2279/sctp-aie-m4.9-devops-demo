# devops-demo

## Getting started

Clone the repository:

```bash
git clone https://github.com/aie-devops/devops-demo.git
cd devops-demo
```

## Requirements

- Java 21 (JDK)
- Maven 3.9+

### Installing Java and Maven with SDKMAN

If you already have [SDKMAN](https://sdkman.io/) installed, install Java 21 and Maven with:

```bash
sdk install java 21.0.12.1-tem
sdk install maven
```

Then verify the versions:

```bash
java -version
mvn -version
```

## Running the app

```bash
mvn spring-boot:run
```

The app starts on [http://localhost:8080](http://localhost:8080) by default.

Alternatively, build a JAR and run it:

```bash
mvn clean package
java -jar target/devops-demo-0.0.1-SNAPSHOT.jar
```

## Running tests

```bash
mvn test
```

## Working with tagged stages

This repo uses tags (e.g. `step-1-project-template`, `step-2-example`, ...) to mark different stages of the app as it evolves. To see all available tags:

```bash
git tag -l
```

To work from a specific stage, create a new branch starting at that tag:

```bash
git checkout -b my-branch-name step-1-project-template
```

This checks out the code exactly as it was at that tag and puts you on a new branch (`my-branch-name`) so you can make changes without affecting the tag or other branches.

