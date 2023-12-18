workspace "Ava"
	architecture "x64"


	configurations
	{
		"Debug",
		"Realease",
		"Distribution"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

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
		"%{prj.name}/src"
	}

	filter "system:windows"
		cppdialect "C++14"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"AVA_PLATFORM_WINDOWS",
			"AVA_BUILD_DLL"
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