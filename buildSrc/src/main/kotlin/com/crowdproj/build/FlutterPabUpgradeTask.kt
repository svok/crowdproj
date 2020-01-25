import org.gradle.api.DefaultTask
import org.gradle.api.Project
import org.gradle.api.provider.Property
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.TaskProvider
import org.gradle.kotlin.dsl.named
import java.io.File

open class FlutterPubUpgradeTask : DefaultTask() {

    init {
        group = FlutterDescription.FLUTTER_GROUP
        description = "Updating all packages of the ${project.name} project"
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
            args = listOf("upgrade")
        }
    }

        companion object {
            const val TASK_NAME = "flutterPubUpgrade"
        }
}

val Project.flutterPubUpgrade: TaskProvider<FlutterBuildRunnerTask>
    get() = tasks.named<FlutterBuildRunnerTask>(FlutterBuildRunnerTask.TASK_NAME)
