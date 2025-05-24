import Hyprland from "gi://AstalHyprland";
import { Variable } from "astal";
import { App, Astal } from "astal/gtk3";

const hyprland = Hyprland.get_default();
const minified = Variable(true);
let nowin = false;

hyprland.connect("event", () => {
	let found = 0;
	for (const client of hyprland.get_clients()) {
		if (client.workspace == hyprland.get_focused_workspace()) {
			found++;
		}
	}

	if (found == 0) {
		nowin = true;
		minified.set(false);
	} else {
		nowin = false;
		minified.set(true);
	}
});

export default function Bar(state) {
	return (
		<window
			name="ShyBar"
			className="ShyBar"
			monitor={0}
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			anchor={
				Astal.WindowAnchor.LEFT |
				Astal.WindowAnchor.TOP |
				Astal.WindowAnchor.BOTTOM
			}
			application={App}
		>
			<eventbox
				onHover={() => {
					if (!nowin) minified.set(false);
				}}
				onHoverLost={() => {
					if (!nowin) minified.set(true);
				}}
			>
				<box
					vertical
					className={minified((value) =>
						value ? "BarContainerMini" : "BarContainer",
					)}
				>
					<Icon minified={minified} />

					<box hexpand vexpand />

					<Time minified={minified} />
				</box>
			</eventbox>
		</window>
	);
}
