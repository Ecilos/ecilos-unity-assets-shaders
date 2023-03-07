Shader "Custom/HexagonalTiles" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _HexSize ("Hex Size", Range(0.01, 0.5)) = 0.1
        _BorderWidth ("Border Width", Range(0.001, 0.05)) = 0.01
        _BorderColor ("Border Color", Color) = (1, 1, 1, 1)
        _TileColor ("Tile Color", Color) = (1, 1, 1, 1)
    }
    SubShader {
        Tags {"Queue"="Transparent" "RenderType"="Opaque"}
        LOD 100

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float _HexSize;
            float _BorderWidth;
            float4 _BorderColor;
            float4 _TileColor;

            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.vertex.xy * 0.5 + 0.5;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target {
                float2 uv = i.uv;
                float2 center = float2(0.5, 0.5);
                float2 hex = floor(uv / (_HexSize * 2.0));
                uv -= hex * _HexSize * 2.0;
                uv.x *= sqrt(3.0) / 2.0;
                if (hex.x % 2.0 == 1.0) {
                    uv.y -= 0.5;
                }
                float dist = length(uv - center);
                float border = smoothstep(_HexSize - _BorderWidth, _HexSize, dist);
                fixed4 color = lerp(_BorderColor, _TileColor, border);
                return color;
            }
            ENDCG
        }
    }
}