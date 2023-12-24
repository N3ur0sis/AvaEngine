#pragma once
#include <Engine/Core/Core.h>
namespace Ava
{
 struct FrameBufferSpecification {
		uint32_t width, height;
		uint32_t samples = 1;
		bool swapChainTarget = false;
	};

	class FrameBuffer
	{
	public:
		virtual void Bind() = 0;
		virtual void Unbind() = 0;
		virtual void Resize(uint32_t width, uint32_t height) = 0;
		virtual uint32_t GetFrameTexture() = 0;
		static FrameBuffer* Create(const FrameBufferSpecification& spec);
	};

}
