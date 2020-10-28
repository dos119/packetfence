import {
  BaseFormButtonBar,
  BaseFormGroupChosenOne,
  BaseFormGroupChosenMultiple,
  BaseFormGroupInput,
  BaseFormGroupInputNumber,
  BaseFormGroupInputPassword,
  BaseFormGroupTextarea,
  BaseFormGroupToggle,
  BaseFormGroupToggleNY
} from '@/components/new/'
import {
  BaseFormGroupIntervalUnit
} from '@/views/Configuration/_components/new/'
import BaseFormGroupActions from './BaseFormGroupActions'
import BaseFormGroupEnabled from './BaseFormGroupEnabled'
import BaseFormGroupTriggers from './BaseFormGroupTriggers'
import TheForm from './TheForm'
import TheView from './TheView'

export {
  BaseFormButtonBar           as FormButtonBar,

  BaseFormGroupActions        as FormGroupActions,
  BaseFormGroupIntervalUnit   as FormGroupDelayBy,
  BaseFormGroupInput          as FormGroupDescription,
  BaseFormGroupEnabled        as FormGroupEnabled,
  BaseFormGroupIntervalUnit   as FormGroupGrace,
  BaseFormGroupInput          as FormGroupIdentifier,
  BaseFormGroupInputNumber    as FormGroupPriority,
  BaseFormGroupTriggers       as FormGroupTriggers,
  BaseFormGroupChosenMultiple as FormGroupWhitelistedRoles,
  BaseFormGroupIntervalUnit   as FormGroupWindow,
  BaseFormGroupToggle         as FormGroupWindowDynamic,

  TheForm,
  TheView
}

