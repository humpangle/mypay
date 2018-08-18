import gql from "graphql-tag";

import { shiftFragment } from "./shift.fragment";
import { newShiftUrlFragment } from "./new-shift-url.fragment";
import { offlineTokenFragment } from "./offline-token.fragment";

export const InitialSocketData = gql`
  query GetInitialSocketData($shift: GetShiftInput) {
    shifts(shift: $shift) {
      ...ShiftFragment
    }

    newShiftUrl {
      ...NewShiftUrlFragment
    }

    offlineToken {
      ...OfflineTokenFragment
    }
  }

  ${shiftFragment}
  ${newShiftUrlFragment}
  ${offlineTokenFragment}
`;

export default InitialSocketData;