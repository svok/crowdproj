import org.gradle.api.Project
import org.gradle.kotlin.dsl.register
import java.io.File

data class FlutterDescription(
    var flutterCommand: String = DEFAULT_FLUTTER_COMMAND,
    var workDir: String = ""
) {
    companion object {
        const val DEFAULT_FLUTTER_COMMAND = "/bin/bash"
        const val FLUTTER_GROUP = "flutter"
    }
}

fun Project.flutter(block: FlutterDescription.() -> Unit) {

    val taskData = FlutterDescription(
        workDir = project.projectDir.toString()
    )
    taskData.block()

    val hasMain = File("${taskData.workDir}/lib/main.dart").exists()

    tasks.register<FlutterInitTask>(FlutterInitTask.TASK_NAME) {
        flutterCommand.set(taskData.flutterCommand)
        flutterProjectDir.set(taskData.workDir)
    }

    tasks.register<FlutterPubUpgradeTask>(FlutterPubUpgradeTask.TASK_NAME) {
        flutterCommand.set(taskData.flutterCommand)
        flutterProjectDir.set(taskData.workDir)
        inputs.files("${taskData.workDir}/pubspec.yaml")
        outputs.files("${taskData.workDir}/pubspec.yaml")
    }

    tasks.register<FlutterBuildRunnerTask>(FlutterBuildRunnerTask.TASK_NAME) {
        dependsOn(FlutterPubUpgradeTask.TASK_NAME)
        flutterCommand.set(taskData.flutterCommand)
        flutterProjectDir.set(taskData.workDir)
        inputs.files(fileTree(taskData.workDir))
    }

    if (hasMain) {
        tasks.register<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_LINUX) {
            dependsOn(FlutterPubUpgradeTask.TASK_NAME)
            architecture.set("linux")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/linux"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
            outputs.files(
                fileTree("$dir/build/linux/release")
            )

        }

        tasks.register<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_WINDOWS) {
            architecture.set("windows")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/windows"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
        }

        tasks.register<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_WEB) {
            architecture.set("web")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/web"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
            outputs.files(
                fileTree("$dir/build/web")
            )
        }

        tasks.register<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_ANDROID) {
            architecture.set("android")
            buildPackage.set("appbundle")
            buildPlatforms.addAll("android-arm", "android-arm64", "android-x64")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/android"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
            outputs.files(
                fileTree("$dir/build/app/outputs/bundle")
            )
        }

        tasks.register<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_IOS) {
            architecture.set("ios")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/ios"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
        }

        tasks.register<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_MACOS) {
            architecture.set("macos")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/macos"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
        }


        tasks.register<FlutterRunTask>(FlutterRunTask.TASK_NAME_LINUX) {
            dependsOn(FlutterPubUpgradeTask.TASK_NAME)
            architecture.set("linux")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/linux"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
            outputs.files(
                fileTree("$dir/build/linux/release")
            )

        }

        tasks.register<FlutterRunTask>(FlutterRunTask.TASK_NAME_WINDOWS) {
            architecture.set("windows")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/windows"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
        }

        tasks.register<FlutterRunTask>(FlutterRunTask.TASK_NAME_WEB) {
            architecture.set("web")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/web"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
            outputs.files(
                fileTree("$dir/build/web")
            )
        }

        tasks.register<FlutterRunTask>(FlutterRunTask.TASK_NAME_ANDROID) {
            architecture.set("android")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/android"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
            outputs.files(
                fileTree("$dir/build/app/outputs/bundle")
            )
        }

        tasks.register<FlutterRunTask>(FlutterRunTask.TASK_NAME_IOS) {
            architecture.set("ios")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/ios"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
        }

        tasks.register<FlutterRunTask>(FlutterRunTask.TASK_NAME_MACOS) {
            architecture.set("macos")
            flutterCommand.set(taskData.flutterCommand)
            val dir = taskData.workDir
            flutterProjectDir.set(dir)
            inputs.files(
                fileTree("$dir/macos"),
                fileTree("$dir/assets"),
                fileTree("$dir/fonts"),
                fileTree("$dir/lib")
            )
        }
    }
}
