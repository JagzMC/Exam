Shader "Custom/VertexColoring"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic (R)", 2D) = "white" {}
        _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderPipeline" = "UniversalRenderPipeline" }
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct v2f
            {
                float4 pos : SV_POSITION;
                float4 color: COLOR;
                float2 uv : TEXCOORD0;
            };
            TEXTURE2D(_MetallicTex);
            SAMPLER(sampler_MetallicTex);
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                o.uv = v.uv;
                o.color.r = (v.vertex.x + 5) /10;
                o.color.g = (v.vertex.z + 5) /10;
                o.color.b = 0.5;
                o.color.a = 1.0;
                return o;
            }
            half4 frag (v2f i) : SV_Target
            {
                half4 texColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv);
                return texColor * i.color;
            }
            ENDHLSL
        }
    }
    FallBack "Diffuse"
}
