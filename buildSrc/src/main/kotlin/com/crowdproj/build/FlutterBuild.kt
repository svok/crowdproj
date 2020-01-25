import org.gradle.api.DefaultTask
import org.gradle.api.GradleException
import org.gradle.api.Project
import org.gradle.api.provider.ListProperty
import org.gradle.api.provider.Property
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.Optional
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.TaskProvider
import org.gradle.kotlin.dsl.named
import java.io.File

open class FlutterBuildTask: DefaultTask() {

    init {
        group = FlutterDescription.FLUTTER_GROUP
        description = "Build ${project.name} project"
    }

    @Input
    val architecture: Property<String> = project.objects.property(String::class.java)

    @Optional
    @Input
    val buildPackage: Property<String> = project.objects.property(String::class.java)

    @Optional
    @Input
    val buildPlatforms: ListProperty<String> = project.objects.listProperty(String::class.java)

    @Input
    val flutterCommand: Property<String> = project.objects.property(String::class.java)
        .apply { set(FlutterDescription.DEFAULT_FLUTTER_COMMAND) }
    @Input
    val flutterProjectDir: Property<String> = project.objects.property(String::class.java)
        .apply { set(project.projectDir.toString()) }

//    val inputs:

    @TaskAction
    fun run() {
        val execArgs = mutableListOf<String>(
            "build"
        )
        if (buildPackage.isPresent) {
            println("BUILD PACKAGE = ${buildPackage.get()}")
            execArgs.add(buildPackage.get())
        } else if (architecture.isPresent) {
            execArgs.add(architecture.get())
        } else {
            throw GradleException("You must provie either architechture or buildPackage parameter for flutterBuild tasks")
        }
        if (buildPlatforms.isPresent && buildPlatforms.get().isNotEmpty()) {
            println("BUILD PLATFORMS = ${buildPlatforms.get()}")
            execArgs.addAll(listOf(
                "--target-platform",
                buildPlatforms.get().joinToString(",")
            ))
        }
        project.exec {
            workingDir = File(flutterProjectDir.get())
            executable = flutterCommand.get()
            args = execArgs
        }
    }

        companion object {
            const val TASK_NAME_ANDROID = "flutterBuildAndroid"
            const val TASK_NAME_LINUX = "flutterBuildLinux"
            const val TASK_NAME_WEB = "flutterBuildWeb"
            const val TASK_NAME_WINDOWS = "flutterBuildWindows"
            const val TASK_NAME_IOS = "flutterBuildIos"
            const val TASK_NAME_MACOS = "flutterBuildMacos"
        }
}

val Project.flutterBuildLinux: TaskProvider<FlutterBuildTask>
    get() = tasks.named<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_LINUX)
val Project.flutterBuildAndroid: TaskProvider<FlutterBuildTask>
    get() = tasks.named<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_ANDROID)
val Project.flutterBuildWindows: TaskProvider<FlutterBuildTask>
    get() = tasks.named<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_WINDOWS)
val Project.flutterBuildWeb: TaskProvider<FlutterBuildTask>
    get() = tasks.named<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_WEB)
val Project.flutterBuildIos: TaskProvider<FlutterBuildTask>
    get() = tasks.named<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_IOS)
val Project.flutterBuildMacos: TaskProvider<FlutterBuildTask>
    get() = tasks.named<FlutterBuildTask>(FlutterBuildTask.TASK_NAME_MACOS)
