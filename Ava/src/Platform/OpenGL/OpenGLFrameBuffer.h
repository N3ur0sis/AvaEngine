#pragma once
#include <Engine/Renderer/FrameBuffer.h>
namespace Ava
{
	class OpenGLFrameBuffer : public FrameBuffer
	{
	public:
		OpenGLFrameBuffer(const FrameBufferSpecification& spec);
		virtual ~OpenGLFrameBuffer();

		virtual void Bind() override;
		virtual void Unbind() override;
		virtual void Resize(uint32_t width, uint32_t height) override;
		virtual uint32_t GetFrameTexture() override;
	private:
		uint32_t m_fbo = 0;
		uint32_t m_texture = 0;
		uint32_t m_rbo = 0;
		FrameBufferSpecification m_Specification;
	};


}
