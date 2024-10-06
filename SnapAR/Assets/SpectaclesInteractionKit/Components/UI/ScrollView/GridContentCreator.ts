@component
export class GridContentCreator extends BaseScriptComponent {

  @input
      itemPrefab: ObjectPrefab;
  @input
      itemsCount: number = 10;

  onAwake() {
      if (!this.itemPrefab) {
          throw new Error('ItemPrefab is not wired in SceneObject:' +
          this.getSceneObject().name);
      }

      const yStart = 0;
      const yOffset = -5.4;

      for (let i = 0; i < this.itemsCount; i++) {
          const item = this.itemPrefab.instantiate(this.getSceneObject());
          const screenTransform = item.getComponent('Component.ScreenTransform');
          screenTransform.offsets.setCenter(new vec2(0, yStart + yOffset * i));
          item.enabled = true;
      }
  }
}
