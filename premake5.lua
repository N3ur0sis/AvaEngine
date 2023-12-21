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
		
	project "GLAD"
		location "Ava/submodules/GLAD"
		kind "StaticLib"
		language "C"
		staticruntime "off"
		warnings "off"
		
		targetdir ("bin/" .. outputdir .. "/%{prj.name}")
		objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
		
		files
		{
			"Ava/submodules/GLAD/include/glad/glad.h",
			"Ava/submodules/GLAD/include/KHR/khrplatform.h",
			"Ava/submodules/GLAD/src/glad.c"
		}
	
		includedirs
		{
			"Ava/submodules/GLAD/include"
		}
	
	
	
		filter "system:windows"
			systemversion "latest"
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

	project "ImGui"
		kind "StaticLib"
		location "Ava/submodules/imgui"
		language "C++"
	
		targetdir ("bin/" .. outputdir .. "/%{prj.name}")
		objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
	
		files
		{
			"Ava/submodules/imgui/imconfig.h",
			"Ava/submodules/imgui/imgui.h",
			"Ava/submodules/imgui/imgui.cpp",
			"Ava/submodules/imgui/imgui_draw.cpp",
			"Ava/submodules/imgui/imgui_internal.h",
			"Ava/submodules/imgui/imgui_widgets.cpp",
			"Ava/submodules/imgui/imstb_rectpack.h",
			"Ava/submodules/imgui/imstb_textedit.h",
			"Ava/submodules/imgui/imstb_truetype.h",
			"Ava/submodules/imgui/imgui_demo.cpp"
		}
	
		filter "system:windows"
			systemversion "latest"
			cppdialect "C++17"
			staticruntime "On"
	
		filter "system:linux"
			pic "On"
			systemversion "latest"
			cppdialect "C++17"
			staticruntime "On"
	
		filter "configurations:Debug"
			runtime "Debug"
			symbols "on"
	
		filter "configurations:Release"
			runtime "Release"
			optimize "on"
	
	
	
group ""
	
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
		"%{IncludeDir.GLAD}",
		"%{IncludeDir.ImGui}",
		"%{prj.name}/src" 
	}

	links 
	{ 
		"GLFW",
		"GLAD",
		"ImGui",
		"opengl32.lib",
		"dwmapi.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"AVA_PLATFORM_WINDOWS",
			"AVA_BUILD_DLL",
			"AVA_ENABLE_ASSERTS",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" ..outputdir .. "/AvaEditor"),
		}

	filter "configurations:debug"
		defines "AVA_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:release"
		defines "AVA_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:distribution"
		defines "AVA_DISTRIBUTION"
		buildoptions "/MD"
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
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:release"
		defines "AVA_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:distribution"
		defines "AVA_DISTRIBUTION"
		buildoptions "/MD"
		optimize "On"


project "AvaEditor"
	location "AvaEditor"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++14"
	staticruntime "On"

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
		systemversion "latest"

		defines
		{
			"AVA_PLATFORM_WINDOWS"
		}
	
	
	filter "configurations:debug"
		defines "AVA_DEBUG"
		buildoptions "/MDd"
		symbols "On"
	
	filter "configurations:release"
		defines "AVA_RELEASE"
		buildoptions "/MD"
		optimize "On"
	
	filter "configurations:distribution"
		defines "AVA_DISTRIBUTION"
		buildoptions "/MD"
		optimize "On"
	
	
	