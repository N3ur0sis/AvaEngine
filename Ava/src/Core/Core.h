#pragma once
#ifdef AVA_PLATFORM_WINDOWS
	#ifdef AVA_BUILD_DLL
		#define AVA_API _declspec(dllexport)
	#else
		#define AVA_API _declspec(dllimport)
	#endif // AVA_BUILD_DLL
#else
	#error Ava currently only runs on Windows.
#endif // AVA_PLATFORM_WINDOWS

#define BIT(x) (1 << x) 