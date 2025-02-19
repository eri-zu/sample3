import {
  PlaneGeometry,
  MeshBasicMaterial,
  Mesh,
  Group,
  RawShaderMaterial,
} from "three";
import { radian } from "../../util/math";
import vert from "./shader/main.vert";
import frag from "./shader/main.frag";

export class Objs {
  constructor(texture) {
    this.mesh;
    this.texture = texture;

    this.PARAM = {
      color: "#fff",
      w: window.innerWidth,
      h: window.innerHeight,
      s: 100,
    };

    this.init();
    this.setEvents();
  }

  init() {
    const g = new PlaneGeometry(this.PARAM.w, this.PARAM.h, this.PARAM.s);

    const m = new RawShaderMaterial({
      vertexShader: vert,
      fragmentShader: frag,
      uniforms: {
        uTime: { value: 0 },
      },
    });

    this.mesh = new Mesh(g, m);
  }

  onUpdate(timeDelta, time) {
    // this.mesh.rotation.x += timeDelta * 0.2;
    // this.mesh.rotation.y += timeDelta * 0.2;
    this.mesh.material.uniforms.uTime.value = time;
    // this.mesh.rotation.x = time * 0.1;
    // this.mesh.rotation.y = time * 0.1;
  }

  onResize(w, h) {}

  setEvents() {}
}
