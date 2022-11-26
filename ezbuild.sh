#!/bin/bash

PROJECT="Test"

init() {
        mkdir $PROJECT
        mkdir $PROJECT/src
        mkdir $PROJECT/src/main
        mkdir $PROJECT/src/main/java
        mkdir $PROJECT/src/main/resources
        mkdir $PROJECT/src/main/filters
        mkdir $PROJECT/src/main/webapp
        mkdir $PROJECT/src/test
        mkdir $PROJECT/src/test/resources
        mkdir $PROJECT/src/test/filters
        mkdir $PROJECT/src/it
        mkdir $PROJECT/src/assembly
        mkdir $PROJECT/src/site
        mkdir $PROJECT/target

        touch $PROJECT/LICENSE.txt
        touch $PROJECT/NOTICE.txt
        touch $PROJECT/README.txt

        touch $PROJECT/src/main/java/$PROJECT.java

        echo -e "class ${PROJECT} {\n\tpublic static void main(String[] args) {\n\t\tSystem.out.println(\"Hello, World!\");\n\t}\n}" > $PROJECT/src/main/java/$PROJECT.java

        echo "Initial setup of ${PROJECT} successful!"
}

build() {
        javac $PROJECT/src/main/java/$PROJECT.java
        mv $PROJECT/src/main/java/*.class $PROJECT/target
        echo "Build of ${PROJECT} successful!"
}

run() {
        java $PROJECT/src/main/java/$PROJECT.java
}

delete() {
        read -p "Are you sure want to delete ${PROJECT}? This will delete the project forever. (y/n): " confirm
        if [ $confirm == "y" ]
        then
                rm -rf $PROJECT
                ls
        fi
}

ship() {
        mkdir $PROJECT/target/dist
        touch $PROJECT/manifest.mf
        echo "Main-Class: ${PROJECT}\n" > $PROJECT/manifest.mf
        jar -cvmf $PROJECT/manifest.mf $PROJECT/target/dist/$PROJECT.jar $PROJECT/target/*.class
        echo "Successfully made ${PROJECT} jar file! (check the target directory)"
}

$1
