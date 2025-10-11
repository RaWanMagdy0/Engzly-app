plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.engzly"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.engzly"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
    create("release") {
        val storeFilePath = project.findProperty("MYAPP_UPLOAD_STORE_FILE")?.toString()
        val storePassword = project.findProperty("MYAPP_UPLOAD_STORE_PASSWORD")?.toString()
        val keyAlias = project.findProperty("MYAPP_UPLOAD_KEY_ALIAS")?.toString()
        val keyPassword = project.findProperty("MYAPP_UPLOAD_KEY_PASSWORD")?.toString()

        if (storeFilePath != null) {
            storeFile = file(storeFilePath)
        }
        this.storePassword = storePassword
        this.keyAlias = keyAlias
        this.keyPassword = keyPassword
    }
}

buildTypes {
    getByName("release") {
        signingConfig = signingConfigs.getByName("release")
        isMinifyEnabled = false
        isShrinkResources = false
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}



    
}

flutter {
    source = "../.."
}
