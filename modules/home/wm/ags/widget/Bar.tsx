import Battery from "gi://AstalBattery";
import Hyprland from "gi://AstalHyprland";
import Mpris from "gi://AstalMpris";
import Network from "gi://AstalNetwork";
import Tray from "gi://AstalTray";
import Wp from "gi://AstalWp";
import { GLib, Variable, bind } from "astal";
import { App } from "astal/gtk3";
import { Astal, type Gdk, Gtk, type Widget } from "astal/gtk3";

function SysTray() {
	const tray = Tray.get_default();

	for (const item of tray.get_items()) {
		print(item.title);
	}

	return (
		<box className="SysTray">
			{bind(tray, "items").as((items) =>
				items.map((item) => (
					<menubutton
						tooltipMarkup={bind(item, "tooltipMarkup")}
						usePopover={false}
						actionGroup={bind(item, "actionGroup").as((ag) => ["dbusmenu", ag])}
						menuModel={bind(item, "menuModel")}
					>
						<icon gicon={bind(item, "gicon")} />
					</menubutton>
				)),
			)}
		</box>
	);
}

function Wifi() {
	const network = Network.get_default();
	const wifi = bind(network, "wifi");

	return (
		<box visible={wifi.as(Boolean)}>
			{wifi.as(
				(wifi) =>
					wifi && (
						<icon
							tooltipText={bind(wifi, "ssid").as(String)}
							className="Wifi"
							icon={bind(wifi, "iconName")}
						/>
					),
			)}
		</box>
	);
}

function AudioSlider() {
	const speaker = Wp.get_default()?.audio.defaultSpeaker!;

	return (
		<box className="AudioSlider" css="min-width: 140px">
			<icon icon={bind(speaker, "volumeIcon")} />
			<slider
				hexpand
				onDragged={({ value }) => (speaker.volume = value)}
				value={bind(speaker, "volume")}
			/>
		</box>
	);
}

function BatteryLevel() {
	const bat = Battery.get_default();

	return (
		<box className="Battery" visible={bind(bat, "isPresent")}>
			<icon icon={bind(bat, "batteryIconName")} />
			<label
				label={bind(bat, "percentage").as((p) => `${Math.floor(p * 100)} %`)}
			/>
		</box>
	);
}

function Media() {
	const mpris = Mpris.get_default();

	return (
		<box className="Media">
			{bind(mpris, "players").as((ps) =>
				ps[0] ? (
					<box>
						<box
							className="Cover"
							valign={Gtk.Align.CENTER}
							css={bind(ps[0], "coverArt").as(
								(cover) => `background-image: url('${cover}');`,
							)}
						/>
						<label
							label={bind(ps[0], "metadata").as(
								() => `${ps[0].title} - ${ps[0].artist}`,
							)}
						/>
					</box>
				) : (
					<label />
				),
			)}
		</box>
	);
}

function Workspaces() {
	const hypr = Hyprland.get_default();

	// I may do it so a workspace number only show on the monitor is open
	return (
		<box className="Workspaces">
			{bind(hypr, "workspaces").as((wss) =>
				wss
					.filter((ws) => !(ws.id >= -99 && ws.id <= -2))
					.sort((a, b) => a.id - b.id)
					.map((ws) => (
						<button
							className={bind(hypr, "focusedWorkspace").as((fw) =>
								ws === fw ? "focused" : "",
							)}
							onClicked={() => ws.focus()}
						>
							{ws.id}
						</button>
					)),
			)}
		</box>
	);
}

function FocusedClient() {
	const hypr = Hyprland.get_default();
	const focused = bind(hypr, "focusedClient");

	return (
		<box className="Focused" visible={focused.as(Boolean)}>
			{focused.as(
				(client) =>
					client && <label label={bind(client, "title").as(String)} />,
			)}
		</box>
	);
}

function Date({ format = "%a %d %b" }) {
	const date = Variable<string>("").poll(
		1000,
		() => GLib.DateTime.new_now_local().format(format)!,
	);

	return (
		<label className="Date" onDestroy={() => date.drop()} label={date()} />
	);
}

function Time({ format = "%H:%M" }) {
	const time = Variable<string>("").poll(
		1000,
		() => GLib.DateTime.new_now_local().format(format)!,
	);

	return (
		<label className="Time" onDestroy={() => time.drop()} label={time()} />
	);
}

function TestW() {
	const count = Variable(false);

	function increment() {
		count.set(true);
		print("clicked button");
	}
	return (
		<box>
			<button onClicked={increment}>ad</button>
			{count.get() === true && <box>cool</box>}
		</box>
	);
}

type MenuProps = Pick<
	Widget.WindowProps,
	// | "name"
	// | "namespace"
	// | "className"
	| "visible"
	// | "child"
	| "marginBottom"
	| "marginTop"
	| "marginLeft"
	| "marginRight"
	| "halign"
	| "valign"
> & {
	onClose?(self: Widget.Window): void;
};

function Menu({
	onClose,
	halign,
	valign,
	marginBottom,
	marginTop,
	marginLeft,
	marginRight,
	...props
}: MenuProps) {
	return (
		<window {...props}>
			<box
				expand
				halign={halign}
				valign={valign}
				marginBottom={marginBottom}
				marginTop={marginTop}
				marginStart={marginLeft}
				marginEnd={marginRight}
			>
				<button onClicked={(self) => onClose(self)}>close</button>
			</box>
		</window>
	);
}

export default function Bar(monitor: Gdk.Monitor) {
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

	const v = Variable(false);

	return (
		<window
			className="Bar"
			gdkmonitor={monitor}
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			anchor={TOP | LEFT | RIGHT}
		>
			<Menu
				valign={Gtk.Align.START}
				halign={Gtk.Align.END}
				marginTop={36}
				marginRight={60}
				visible={v()}
				onClose={() => v.set(false)}
			/>
			<centerbox>
				<box hexpand halign={Gtk.Align.START}>
					<Workspaces />
					<button onClicked={() => v.set(true)}>open</button>
				</box>
				<box>
					<Media />
				</box>
				<box hexpand halign={Gtk.Align.END}>
					<SysTray />
					<Wifi />
					<AudioSlider />
					<BatteryLevel />
					<Date />
					<Time />
				</box>
			</centerbox>
		</window>
	);
}
