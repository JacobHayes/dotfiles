#!/usr/bin/env python3
#
# Change the iterm theme (without resetting the font/window size).
#
# The theme can be changed with `echo -e "\033]50;SetProfile=${theme}\a"` (requiring
# extra escape padding if in tmux), but that will reset the font size (and change window
# size, depending on settings).
import iterm2

THEME = "dark"


async def main(connection):
    matching_profiles = [
        p for p in await iterm2.Profile.async_get(connection) if p.name == THEME
    ]
    assert len(matching_profiles) == 1
    target_properties = matching_profiles[0].local_write_only_copy

    app = await iterm2.async_get_app(connection)
    if (window := app.current_window) is not None:
        if (tab := window.current_tab) is not None:
            if (session := tab.current_session) is not None:
                current_profile = await session.async_get_profile()
                # Override font size in the target profile in case we zoomed in manually
                target_properties.set_non_ascii_font(current_profile.non_ascii_font)
                target_properties.set_normal_font(current_profile.normal_font)
                await session.async_set_profile_properties(target_properties)


if __name__ == "__main__":
    from argparse import ArgumentParser

    _parser = ArgumentParser(
        description="Change the iTerm theme (without changing fonts)"
    )
    _parser.add_argument("theme", help="name of the theme", default=THEME)
    _args = _parser.parse_args()
    THEME = _args.theme
    iterm2.run_until_complete(main)
