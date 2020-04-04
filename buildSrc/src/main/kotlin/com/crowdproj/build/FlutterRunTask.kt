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

open class FlutterRunTask: DefaultTask() {

    init {
        group = FlutterDescription.FLUTTER_GROUP
        description = "Run ${project.name} project"
    }

    @Input
    val architecture: Property<String> = project.objects.property(String::class.java)

    @Input
    val flutterCommand: Property<String> = project.objects.property(String::class.java)
        .apply { set(FlutterDescription.DEFAULT_FLUTTER_COMMAND) }
    @Input
    val flutterProjectDir: Property<String> = project.objects.property(String::class.java)
        .apply { set(project.projectDir.toString()) }

    @TaskAction
    fun run() {
        val execArgs = mutableListOf<String>(
            "flutter",
            "run"
        )
        if (architecture.isPresent) {
            execArgs.add("-d")
            execArgs.add(architecture.get())
        } else {
            throw GradleException("You must provie either architechture or buildPackage parameter for flutterRun tasks")
        }
        project.exec {
            workingDir = File(flutterProjectDir.get())
            executable = flutterCommand.get()
            args = listOf("-c", execArgs.joinToString(" "))
        }
    }

        companion object {
            const val TASK_NAME_ANDROID = "flutterRunAndroid"
            const val TASK_NAME_LINUX = "flutterRunLinux"
            const val TASK_NAME_WEB = "flutterRunWeb"
            const val TASK_NAME_WINDOWS = "flutterRunWindows"
            const val TASK_NAME_IOS = "flutterRunIos"
            const val TASK_NAME_MACOS = "flutterRunMacos"
        }
}

val Project.flutterRunLinux: TaskProvider<FlutterRunTask>
    get() = tasks.named<FlutterRunTask>(FlutterRunTask.TASK_NAME_LINUX)
val Project.flutterRunAndroid: TaskProvider<FlutterRunTask>
    get() = tasks.named<FlutterRunTask>(FlutterRunTask.TASK_NAME_ANDROID)
val Project.flutterRunWindows: TaskProvider<FlutterRunTask>
    get() = tasks.named<FlutterRunTask>(FlutterRunTask.TASK_NAME_WINDOWS)
val Project.flutterRunWeb: TaskProvider<FlutterRunTask>
    get() = tasks.named<FlutterRunTask>(FlutterRunTask.TASK_NAME_WEB)
val Project.flutterRunIos: TaskProvider<FlutterRunTask>
    get() = tasks.named<FlutterRunTask>(FlutterRunTask.TASK_NAME_IOS)
val Project.flutterRunMacos: TaskProvider<FlutterRunTask>
    get() = tasks.named<FlutterRunTask>(FlutterRunTask.TASK_NAME_MACOS)
