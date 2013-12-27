Shader "Sprites/Transparent Vertex Color" {
Properties {
    _MainTex ("Texture", 2D) = "white" {}
}

Category {
    Tags { "Queue"="Transparent" }
    Lighting Off
    ZWrite Off
    
    Blend SrcAlpha OneMinusSrcAlpha
    
    BindChannels {
        Bind "Color", color
        Bind "Vertex", vertex
        Bind "TexCoord", texcoord
    }
    
    SubShader {
        Pass {
            SetTexture [_MainTex] {
                Combine texture * primary DOUBLE
            }
        }
    }
}
}