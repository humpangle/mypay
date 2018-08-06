import { ajax } from "rxjs/ajax";

interface JsonResponseTag {
  name: string;
  attrs: { [key: string]: string };
}

interface JsonResponse {
  html: string;
  tag: JsonResponseTag;
}

const makeTag = ({ name, attrs }: JsonResponseTag) => {
  const tagEl = document.createElement(name);

  for (const [attr, value] of Object.entries(attrs)) {
    tagEl.setAttribute(attr, value);
  }

  return tagEl;
};

// tslint:disable-next-line:only-arrow-functions
(function() {
  const newMetaFormUrl = window.appInterface.newMetaFormUrl;
  const modalParentEl = window.appInterface.modalParentEl;

  if (!newMetaFormUrl || !modalParentEl) {
    return;
  }

  ajax({
    url: newMetaFormUrl,
    responseType: "json"
  })
    // tslint:disable-next-line:no-console
    .subscribe(json => {
      const response = json.response as JsonResponse;
      const tag = makeTag(response.tag);
      document.head.appendChild(tag);
      modalParentEl.innerHTML = response.html;
    });
})();

// const fetchNewMetaBtn = document.getElementById("get-new-meta-form-button");

// if (fetchNewMetaBtn) {
//   fetchNewMetaBtn.addEventListener("click", fetchNewMetaForm, false);
// }