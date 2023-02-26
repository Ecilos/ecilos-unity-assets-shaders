Shader "Custom/Spiral01"
{
    Properties {
        _Speed ("Speed", Range(0, 10)) = 1.0
        _Amount ("Amount", Range(0, 1)) = 0.1
        _Color ("Color", Color) = (1, 1, 1, 1)
    }

    SubShader {
        Tags {"RenderType"="Opaque"}
        LOD 200

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float _Speed;
            float _Amount;
            float4 _Color;

            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target {
                float2 uv = i.uv;
                float4 col = _Color;
                float noise = _Amount * sin(uv.x * 10 + _Time.y * _Speed) + _Amount * sin(uv.y * 10 + _Time.y * _Speed);
                float angle = atan2(uv.y - 0.5, uv.x - 0.5) + noise;
                float radius = length(uv - 0.5);
                col.r = radius * cos(angle);
                col.g = radius * sin(angle);
                return col;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
