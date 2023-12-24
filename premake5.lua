workspace "Ava"
    architecture "x64"
    startproject "AvaEditor"


    configurations
    {
        "Debug",
        "Realease",
        "Distribution"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "Ava/submodules/GLFW/include"
IncludeDir["GLAD"] = "Ava/submodules/GLAD/include"
IncludeDir["ImGui"] = "Ava/submodules/imgui"


group "Dependencies"

include "Ava/submodules/GLFW"
include "Ava/submodules/GLAD"
include "Ava/submodules/imgui"

group ""
	
project "Ava"
	location "Ava"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "pch.h"
	pchsource "Ava/src/pch.cpp"



	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs
	{
		"%{prj.name}/src" ,
		"%{prj.name}/submodules/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.GLAD}",
		"%{IncludeDir.ImGui}",
	}

	links 
	{ 
		"GLFW",
		"GLAD",
		"ImGui",
		"opengl32.lib",
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"AVA_PLATFORM_WINDOWS",
			"AVA_BUILD_DLL",
			"AVA_ENABLE_ASSERTS",
			"GLFW_INCLUDE_NONE",
			"_SILENCE_ALL_MS_EXT_DEPRECATION_WARNINGS"
		}

	filter "configurations:Debug"
		defines "AVA_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "AVA_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Distribution"
		defines "AVA_DISTRIBUTION"
		runtime "Release"
		optimize "on"

project "SandBox"
	location "SandBox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Ava/submodules/spdlog/include",
		"Ava/src",
		"Ava/submodules/imgui"
	}

	links
	{
		"Ava"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"AVA_PLATFORM_WINDOWS",
			"_SILENCE_ALL_MS_EXT_DEPRECATION_WARNINGS"
		}


	filter "configurations:Debug"
		defines "AVA_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "AVA_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Distribution"
		defines "AVA_DISTRIBUTION"
		runtime "Release"
		optimize "on"


project "AvaEditor"	
	location "AvaEditor"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Ava/submodules/spdlog/include",
		"Ava/src",
		"Ava/submodules"
	}

	links
	{
		"Ava"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"AVA_PLATFORM_WINDOWS",
			"_SILENCE_ALL_MS_EXT_DEPRECATION_WARNINGS"
		}
	
	
	filter "configurations:Debug"
		defines "AVA_DEBUG"
		runtime "Debug"
		symbols "on"
	
	filter "configurations:Release"
		defines "AVA_RELEASE"
		runtime "Release"
		optimize "on"
	
	filter "configurations:Distribution"
		defines "AVA_DISTRIBUTION"
		runtime "Release"
		optimize "on"