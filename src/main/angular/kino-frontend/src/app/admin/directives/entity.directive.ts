import {Directive} from '@angular/core';

@Directive({
  standalone: false,
  selector: '[appEntity]'
})
export class EntityDirective {

  constructor() { }

}
