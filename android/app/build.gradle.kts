import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { localProperties.load(it) }
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

android {
    namespace = "com.data.pilotstar_apk"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

        signingConfigs {
        // Solo crear el signingConfig "release" si existe app/signing.properties
        val signingPropertiesFile = rootProject.file("app/signing.properties")
        if (signingPropertiesFile.exists()) {
            create("release") {
                val signingProperties = Properties()
                signingPropertiesFile.inputStream().use { signingProperties.load(it) }

                val storeFilePath = signingProperties.getProperty("storeFile")?.trim().orEmpty()
                if (storeFilePath.isNotEmpty()) {
                    storeFile = file(storeFilePath)
                }
                storePassword = signingProperties.getProperty("storePassword") ?: ""
                keyAlias = signingProperties.getProperty("keyAlias") ?: ""
                keyPassword = signingProperties.getProperty("keyPassword") ?: ""
            }
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    sourceSets {
        getByName("main") {
            jniLibs.srcDir("src/main/libs")
        }
    }

    defaultConfig {
        applicationId = "com.data.pilotstar_apk"
        manifestPlaceholders["appAuthRedirectScheme"] = "com.data.pilotstar_apk"
        minSdk = 24
        targetSdk = 34
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
        multiDexEnabled = true
        vectorDrawables.useSupportLibrary = true
        ndk { 
           abiFilters.add("arm64-v8a")
           abiFilters.add("x86_64")
           abiFilters.add("armeabi-v7a")
        }
    
        javaCompileOptions {
            annotationProcessorOptions {
                arguments["room.incremental"] = "true"
            }
        }
    }

    buildTypes {
        release {
            // Usar firma de producción si está configurada, sino usar debug
            // NOTA: Si hay problemas con el keystore, cambiar temporalmente a debug
            signingConfig = signingConfigs.findByName("release") ?: signingConfigs.getByName("debug")
            
            // Configuraciones de seguridad para release
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            
            // Configuración de esquemas de firma seguros
            signingConfig?.enableV1Signing = true
            signingConfig?.enableV2Signing = true
            signingConfig?.enableV3Signing = true
            signingConfig?.enableV4Signing = false // Solo para APK splits
            
            packaging {
                jniLibs {
                    useLegacyPackaging = true
                }
            }
        }
        debug {
            packaging {
                jniLibs {
                    useLegacyPackaging = true
                }
            }
        }
    }

    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
        resources {
            excludes += setOf(
                "META-INF/*.version",
                "META-INF/proguard/*",
                "META-INF/services/*"
            )
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.9.0")
}

flutter {
    source = "../.."
}

tasks.withType<JavaCompile>().configureEach {
    options.compilerArgs.addAll(listOf("-Xlint:unchecked", "-Xlint:deprecation"))
    options.encoding = "UTF-8"
}

tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        freeCompilerArgs.addAll(listOf(
            "-Xjvm-default=all",
            "-Xopt-in=kotlin.RequiresOptIn"
        ))
    }
}


