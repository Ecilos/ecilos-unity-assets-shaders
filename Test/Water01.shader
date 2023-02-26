Shader "Custom/Water01"
{
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _Speed ("Speed", Range(0, 10)) = 1.0
        _Amount ("Amount", Range(0, 1)) = 0.1
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

            sampler2D _MainTex;
            float _Speed;
            float _Amount;

            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target {
                float2 uv = i.uv;
                uv.x += _Speed * _Time.y;
                uv.y += _Speed * _Time.y;
                float4 col = tex2D(_MainTex, uv);
                col.r = col.r + _Amount * (sin(_Time.y * 2 + i.uv.x * 10) + sin(_Time.y * 3 + i.uv.y * 10)) * 0.5;
                return col;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
