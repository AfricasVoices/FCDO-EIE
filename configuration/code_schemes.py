import json

from core_data_modules.data_models import CodeScheme


def _open_scheme(filename):
    with open(f"code_schemes/{filename}", "r") as f:
        firebase_map = json.load(f)
        return CodeScheme.from_firebase_map(firebase_map)


class CodeSchemes(object):
    RQA_S10E01 = _open_scheme("rqa_s10e01.json")
    RQA_S10E02 = _open_scheme("rqa_s10e02.json")

    SOMALIA_OPERATOR = _open_scheme("somalia_operator.json")

    AGE = _open_scheme("age.json")
    AGE_CATEGORY = _open_scheme("age_category.json")
    GENDER = _open_scheme("gender.json")
    MOGADISHU_SUB_DISTRICT = _open_scheme("mogadishu_sub_district.json")
    SOMALIA_DISTRICT = _open_scheme("somalia_district.json")
    SOMALIA_REGION = _open_scheme("somalia_region.json")
    SOMALIA_STATE = _open_scheme("somalia_state.json")
    SOMALIA_ZONE = _open_scheme("somalia_zone.json")
    IN_IDP_CAMP = _open_scheme("in_idp_camp.json")
    RECENTLY_DISPLACED = _open_scheme("recently_displaced.json")

    WS_CORRECT_DATASET = _open_scheme("ws_correct_dataset.json")
