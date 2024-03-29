import org.gradle.api.DefaultTask
import org.gradle.api.Project
import org.gradle.api.provider.Property
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.TaskProvider
import org.gradle.kotlin.dsl.named
import java.io.File

open class FlutterInitTask : DefaultTask() {

    init {
        group = FlutterDescription.FLUTTER_GROUP
        description = "Initialization of Flutter for ${project.name}."
    }

    @Input
    val flutterCommand: Property<String> = project.objects.property(String::class.java)
        .apply { set(FlutterDescription.DEFAULT_FLUTTER_COMMAND) }
    @Input
    val flutterProjectDir: Property<String> = project.objects.property(String::class.java)
        .apply { set(project.projectDir.toString()) }

    @TaskAction
    fun run() {
        project.exec {
            workingDir = File(flutterProjectDir.get())
            executable = flutterCommand.get()
            args = listOf("-c", "flutter upgrade")
        }
    }

    companion object {
        const val TASK_NAME = "flutterInit"
    }
}

val Project.flutterInit: TaskProvider<FlutterInitTask>
    get() = tasks.named<FlutterInitTask>(FlutterInitTask.TASK_NAME)
