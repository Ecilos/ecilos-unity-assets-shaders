Shader "Custom/StoneTexture01" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _Occlusion ("Occlusion", Range(0,1)) = 0.5
        _Shininess ("Shininess", Range(0.01, 1)) = 0.078125
    }

    SubShader {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float _Occlusion;
        float _Shininess;

        struct Input {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 worldPos;
            float3 worldNormal;
        };

        void surf (Input IN, inout SurfaceOutputStandard o) {
            // Albedo
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;

            // Normal map
            o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));

            // Occlusion
            o.Metallic = 1.0;
            o.Smoothness = _Shininess;

            // Occlusion.
            o.Occlusion = _Occlusion;
        }
        ENDCG
    }
    FallBack "Diffuse"
}