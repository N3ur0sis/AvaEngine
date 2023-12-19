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

project "GLFW"
	location "Ava/submodules/GLFW"
	kind "StaticLib"
	language "C"
	staticruntime "off"
	warnings "off"
	
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
	
	files
	{
		"Ava/submodules/GLFW/include/GLFW/glfw3.h",
		"Ava/submodules/GLFW/include/GLFW/glfw3native.h",
		"Ava/submodules/GLFW/src/glfw_config.h",
		"Ava/submodules/GLFW/src/context.c",
		"Ava/submodules/GLFW/src/init.c",
		"Ava/submodules/GLFW/src/input.c",
		"Ava/submodules/GLFW/src/monitor.c",

		"Ava/submodules/GLFW/src/null_init.c",
		"Ava/submodules/GLFW/src/null_joystick.c",
		"Ava/submodules/GLFW/src/null_monitor.c",
		"Ava/submodules/GLFW/src/null_window.c",

		"Ava/submodules/GLFW/src/platform.c",
		"Ava/submodules/GLFW/src/vulkan.c",
		"Ava/submodules/GLFW/src/window.c",
	}

	filter "system:linux"
		pic "On"
		systemversion "latest"
		
		files
		{
			"Ava/submodules/GLFW/src/x11_init.c",
			"Ava/submodules/GLFW/src/x11_monitor.c",
			"Ava/submodules/GLFW/src/x11_window.c",
			"Ava/submodules/GLFW/src/xkb_unicode.c",
			"Ava/submodules/GLFW/src/posix_module.c",
			"Ava/submodules/GLFW/src/posix_time.c",
			"Ava/submodules/GLFW/src/posix_thread.c",
			"Ava/submodules/GLFW/src/posix_module.c",
			"Ava/submodules/GLFW/src/glx_context.c",
			"Ava/submodules/GLFW/src/egl_context.c",
			"Ava/submodules/GLFW/src/osmesa_context.c",
			"Ava/submodules/GLFW/src/linux_joystick.c"
		}

		defines
		{
			"_GLFW_X11"
		}

	filter "system:macosx"
		pic "On"

		files
		{
			"Ava/submodules/GLFW/src/cocoa_init.m",
			"Ava/submodules/GLFW/src/cocoa_monitor.m",
			"Ava/submodules/GLFW/src/cocoa_window.m",
			"Ava/submodules/GLFW/src/cocoa_joystick.m",
			"Ava/submodules/GLFW/src/cocoa_time.c",
			"Ava/submodules/GLFW/src/nsgl_context.m",
			"Ava/submodules/GLFW/src/posix_thread.c",
			"Ava/submodules/GLFW/src/posix_module.c",
			"Ava/submodules/GLFW/src/osmesa_context.c",
			"Ava/submodules/GLFW/src/egl_context.c"
		}

		defines
		{
			"_GLFW_COCOA"
		}

	filter "system:windows"
		systemversion "latest"

		files
		{
			"Ava/submodules/GLFW/src/win32_init.c",
			"Ava/submodules/GLFW/src/win32_joystick.c",
			"Ava/submodules/GLFW/src/win32_module.c",
			"Ava/submodules/GLFW/src/win32_monitor.c",
			"Ava/submodules/GLFW/src/win32_time.c",
			"Ava/submodules/GLFW/src/win32_thread.c",
			"Ava/submodules/GLFW/src/win32_window.c",
			"Ava/submodules/GLFW/src/wgl_context.c",
			"Ava/submodules/GLFW/src/egl_context.c",
			"Ava/submodules/GLFW/src/osmesa_context.c"
		}
			defines 
		{ 
			"_GLFW_WIN32",
			"_CRT_SECURE_NO_WARNINGS"
		}
		filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter { "system:windows", "configurations:Debug-AS" }	
		runtime "Debug"
		symbols "on"
		sanitize { "Address" }
		flags { "NoRuntimeChecks", "NoIncrementalLink" }
		filter "configurations:Release"
		runtime "Release"
		optimize "speed"
		filter "configurations:Dist"
		runtime "Release"
		optimize "speed"
		symbols "off"

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


