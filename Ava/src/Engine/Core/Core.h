#pragma once
#ifdef AVA_PLATFORM_WINDOWS
#if AVA_DYNAMIC_BUILD
	#ifdef AVA_BUILD_DLL
		#define AVA_API _declspec(dllexport)
	#else
		#define AVA_API _declspec(dllimport)
	#endif // AVA_BUILD_DLL
#else
	#define AVA_API
#endif
#else
	#error Ava currently only runs on Windows.
#endif // AVA_PLATFORM_WINDOWS

#ifdef AVA_ENABLE_ASSERTS
	#define AVA_ASSERT(x, ...) { if((!x)) { AVA_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
	#define AVA_CORE_ASSERT(x, ...) { if((!x)) { AVA_CORE_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
#else
	#define AVA_ASSERT(x, ...)
	#define AVA_CORE_ASSERT(x, ...)
#endif

#define BIT(x) (1 << x) 