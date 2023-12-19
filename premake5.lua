workspace "Ava"
	architecture "x64"


	configurations
	{
		"Debug",
		"Realease",
		"Distribution"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "Ava/submodules/GLFW/include"

include "Ava/submodules/GLFW"



project "Ava"
	location "Ava"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "pch.h"
	pchsource "Ava/src/pch.cpp"



	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/submodules/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{prj.name}/src" 
	}

	links 
	{ 
		"GLFW",
		"opengl32.lib",
		"dwmapi.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "off"
		runtime "Debug"
		systemversion "latest"

		defines
		{
			"AVA_PLATFORM_WINDOWS",
			"AVA_BUILD_DLL",
			"AVA_ENABLE_ASSERTS"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" ..outputdir .. "/SandBox")
		}

	filter "configurations:debug"
		defines "AVA_DEBUG"
		symbols "On"

	filter "configurations:release"
		defines "AVA_RELEASE"
		optimize "On"

	filter "configurations:distribution"
		defines "AVA_DISTRIBUTION"
		optimize "On"

project "SandBox"
	location "SandBox"
	kind "ConsoleApp"
	language "C++"

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
		"Ava/src"
	}

	links
	{
		"Ava"
	}

	filter "system:windows"
		cppdialect "C++14"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"AVA_PLATFORM_WINDOWS"
		}


	filter "configurations:debug"
		defines "AVA_DEBUG"
		symbols "On"

	filter "configurations:release"
		defines "AVA_RELEASE"
		optimize "On"

	filter "configurations:distribution"
		defines "AVA_DISTRIBUTION"
		optimize "On"